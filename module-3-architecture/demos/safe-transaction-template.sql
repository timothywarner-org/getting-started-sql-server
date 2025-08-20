-- safe-transaction-template.sql
-- Purpose: Safer change pattern for admin/DDL/DML work
-- Usage: Use on your own scripts; do not run as-is against WWI without reviewing statements.

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRAN;

    -- TODO: Place your statements here
    -- Example:
    -- UPDATE dbo.SomeTable SET Col = 'Value' WHERE KeyCol = 42;
    -- ALTER INDEX IX_Some ON dbo.SomeTable REBUILD WITH (ONLINE = ON);

    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRAN;
    -- Re-raise the original error with full context
    THROW;
END CATCH;
