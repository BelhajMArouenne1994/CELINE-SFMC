SELECT
    BounceDV.SubscriberKey AS 'ContactKey',
    Contacts.[Account Id] AS 'Account Id',
    SubsDV.EmailAddress AS 'PersonEmail',
    BounceDV.ListID AS 'ListID',
    BounceDV.EventDate AS 'Date'
FROM
    ENT._Bounce AS BounceDV
    JOIN ENT._Subscribers AS SubsDV ON BounceDV.SubscriberKey = SubsDV.SubscriberKey
    JOIN Contacts ON Contacts.ContactKey = SubsDV.SubscriberKey
WHERE
    BounceDV.AccountID = '510003815'
    /*AND BounceDV.ListID = '82'*/
    AND BounceDV.BounceCategory = 'Hard bounce'
    AND SubsDV.EmailAddress IS NOT NULL
    AND BounceDV.EventDate >= DATEADD(DAY, -1, GETDATE())