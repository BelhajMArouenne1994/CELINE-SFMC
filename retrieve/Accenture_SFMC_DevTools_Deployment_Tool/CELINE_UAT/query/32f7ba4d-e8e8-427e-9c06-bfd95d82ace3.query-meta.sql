SELECT
    ContactKey,
    'Active' AS STATUS,
    Email,
    [Date Of The Update],
    [Old Status],
    [Old Email]
FROM
    UPDATE_ALL_SUBSCRIBERS_LIST_DE AS subs
WHERE
    STATUS = 'Unsubscribed'
    AND [Old Status] = 'Undeliverable'