SELECT
    [Account Id],
    Email,
    ContactKey,
    CASE
        WHEN [Last Send Date Text] = 'NULL' THEN NULL
        ELSE [Last Send Date Text]
    END AS [Last Send Date],
    CASE
        WHEN [Last Open Date Text] = 'NULL' THEN NULL
        ELSE [Last Open Date Text]
    END AS [Last Open Date],
    CASE
        WHEN [Last Click Date Text] = 'NULL' THEN NULL
        ELSE [Last Click Date Text]
    END AS [Last Click Date],
    CASE
        WHEN [First Bounce Text] = 'NULL' THEN NULL
        ELSE [First Bounce Text]
    END AS [First Bounce Date],
    CASE
        WHEN [First Opt Out Text] = 'NULL' THEN NULL
        ELSE [First Opt Out Text]
    END AS [First Opt Out Date]
FROM
    [Ramp Up Cheetah Data] A