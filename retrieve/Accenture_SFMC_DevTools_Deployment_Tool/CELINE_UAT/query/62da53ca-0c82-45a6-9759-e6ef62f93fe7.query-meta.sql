SELECT
    ContactKey,
    Email,
    'active' AS STATUS
FROM
    RESUBSCRIBES_HISTORY_DE
WHERE
    [Date Of Resubscription] >= DateAdd(DAY, -1, cast(GetDate() AS date))