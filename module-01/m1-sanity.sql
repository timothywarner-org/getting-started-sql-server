-- m1-sanity.sql
-- Purpose: Safe, reversible DDL/DML round-trip for Module 1 demo
-- Database: WideWorldImporters (WWI)
-- Usage: Run in SSMS and VS Code MSSQL with Windows Authentication

USE [WideWorldImporters];
GO

BEGIN TRAN;

-- Create lab schema if needed (will be rolled back)
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'globoadmin')
    EXEC(N'CREATE SCHEMA globoadmin AUTHORIZATION dbo;');

-- Ensure a clean slate (safe because we roll back)
IF OBJECT_ID(N'globoadmin.Sandbox_M1', N'U') IS NOT NULL
    DROP TABLE globoadmin.Sandbox_M1;

CREATE TABLE globoadmin.Sandbox_M1
(
    SandboxID  int IDENTITY(1,1) PRIMARY KEY,
    Note       nvarchar(100) NOT NULL,
    CreatedAt  datetime2(0)  NOT NULL DEFAULT (sysdatetime())
);

INSERT INTO globoadmin.Sandbox_M1 (Note)
VALUES (N'Hello Globomantics'), (N'We are live');

SELECT TOP (5) *
FROM globoadmin.Sandbox_M1
ORDER BY SandboxID DESC;

-- Undo all changes for a pristine database post-demo
ROLLBACK TRAN;

-- Should return NULL to prove rollback
SELECT OBJECT_ID(N'globoadmin.Sandbox_M1', N'U') AS ShouldBeNull;
