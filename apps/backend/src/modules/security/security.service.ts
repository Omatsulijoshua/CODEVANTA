import { Injectable } from '@nestjs/common';
import * as crypto from 'crypto';

@Injectable()
export class SecurityService {
  private readonly algorithm = 'aes-256-gcm';
  private readonly secretKey = crypto.scryptSync('CodeVantaSecretKey', 'salt', 32);

  encryptToken(text: string): { iv: string; encryptedData: string; authTag: string } {
    const iv = crypto.randomBytes(16);
    const cipher = crypto.createCipheriv(this.algorithm, this.secretKey, iv);
    let encrypted = cipher.update(text, 'utf8', 'hex');
    encrypted += cipher.final('hex');
    const authTag = cipher.getAuthTag().toString('hex');
    return { iv: iv.toString('hex'), encryptedData: encrypted, authTag };
  }

  decryptToken(encryptedData: string, ivHex: string, authTagHex: string): string {
    const iv = Buffer.from(ivHex, 'hex');
    const authTag = Buffer.from(authTagHex, 'hex');
    const decipher = crypto.createDecipheriv(this.algorithm, this.secretKey, iv);
    decipher.setAuthTag(authTag);
    let decrypted = decipher.update(encryptedData, 'hex', 'utf8');
    decrypted += decipher.final('utf8');
    return decrypted;
  }

  sanitizePrompt(prompt: string): { sanitizedPrompt: string; hasInjectionAttempt: boolean; strippedTokensCount: number } {
    let sanitized = prompt;
    let strippedTokensCount = 0;

    // Detect and strip secret API token patterns
    const tokenRegexes = [
      /sk-[a-zA-Z0-9_\-]{20,}/g,
      /ghp_[a-zA-Z0-9]{36}/g,
      /bearer\s+[a-zA-Z0-9\._\-]+/gi,
    ];

    for (const regex of tokenRegexes) {
      const matches = sanitized.match(regex);
      if (matches) {
        strippedTokensCount += matches.length;
        sanitized = sanitized.replace(regex, '[REDACTED_SECRET_TOKEN]');
      }
    }

    // Detect prompt injection attack strings
    const injectionPatterns = [
      /ignore\s+previous\s+instructions/i,
      /reveal\s+system\s+prompt/i,
      /output\s+all\s+env\s+vars/i,
    ];

    const hasInjectionAttempt = injectionPatterns.some((pattern) => pattern.test(prompt));

    return {
      sanitizedPrompt: sanitized,
      hasInjectionAttempt,
      strippedTokensCount,
    };
  }
}
