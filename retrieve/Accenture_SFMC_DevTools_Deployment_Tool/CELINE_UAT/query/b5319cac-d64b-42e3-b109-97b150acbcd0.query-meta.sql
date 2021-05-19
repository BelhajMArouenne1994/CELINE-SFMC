SELECT
    Account.PersonContactId AS 'Contact Key',
    Transactions.cel_AccountId__c AS 'Account Id',
    TransactionLines.cel_transaction__c AS 'Transaction Id',
    TransactionLines.Id AS 'Transaction Line Id',
    TransactionLines.cel_Product2Id__c AS 'Product Id',
    TransactionLines.cel_Quantity__c AS 'Quantity',
    Products.cel_customer_type_code__c AS 'Type Code',
    Products.cel_creation_season_code__c AS 'Season Code'
FROM
    ENT.cel_Transaction_Line__c_Salesforce AS TransactionLines
    LEFT OUTER JOIN ENT.CEL_TRANSACTION__C_SALESFORCE AS Transactions ON TransactionLines.cel_transaction__c = Transactions.Id
    LEFT OUTER JOIN ENT.PRODUCT2_SALESFORCE AS Products ON TransactionLines.cel_Product2Id__c = Products.Id
    LEFT OUTER JOIN ENT.ACCOUNT_SALESFORCE AS Account ON Transactions.cel_AccountId__c = Account.Id
WHERE
    Account.RecordTypeId = '0121r0000007NppAAE'
    AND Account.cel_ext_account_id__c IS NOT NULL