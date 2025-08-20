CREATE DATABASE AdminSandbox;
GO

USE AdminSandbox;
GO

CREATE TABLE dbo.LabNotes
(
    NoteID int IDENTITY(1,1) PRIMARY KEY,
    CreatedAt datetime2(0) NOT NULL DEFAULT (sysdatetime()),
    Note nvarchar(200) NOT NULL
);
GO

INSERT dbo.LabNotes (Note) VALUES (N'Hello from Module 1');
SELECT * FROM dbo.LabNotes;
UPDATE dbo.LabNotes SET Note = N'Updated note' WHERE NoteID = 1;
DELETE FROM dbo.LabNotes WHERE NoteID = 1;
