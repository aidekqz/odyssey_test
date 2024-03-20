ALTER SYSTEM SET password_encryption = 'md5';
SELECT pg_reload_conf();
SET password_encryption = 'md5';
ALTER ROLE postgres PASSWORD '123456';
