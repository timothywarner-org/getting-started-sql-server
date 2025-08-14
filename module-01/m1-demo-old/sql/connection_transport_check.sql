SELECT session_id, net_transport
FROM sys.dm_exec_connections
WHERE session_id = @@SPID;