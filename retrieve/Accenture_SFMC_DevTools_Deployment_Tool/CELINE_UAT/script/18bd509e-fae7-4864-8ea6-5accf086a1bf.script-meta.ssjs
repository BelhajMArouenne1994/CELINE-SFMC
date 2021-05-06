Platform.Load('core', '1');
try {
    var accDE = DataExtension.Init('Account_Salesforce_DE');
    var data = retrieveAllRecords('Account_Salesforce_DE');
    if (data) {
        for (var i = 0; i < data.length; i++) {
            var region, country, language, baseURL;
            var Id = data[i]['Id'];
            var writtenLanguage = data[i]['cel_written_language__c'];
            var mainStore = data[i]['cel_customer_main_store__c'];
            if (Id && Id != '') {
                language = getLanguage(writtenLanguage);
                country = getCountry(mainStore);
                region = getRegion(mainStore);
                var url = 'https://www.celine.com/';
                baseURL = url.concat(language, '-', country.toLowerCase());
                accDE.Rows.Update(
                    { Language: language, Country: country, Region: region, BaseURL: baseURL },
                    ['Id'],
                    [Id]
                );
            }
        }
    }
} catch (error) {}

function retrieveFieldNames(name) {
    var attr = DataExtension.Retrieve({ Property: 'Name', SimpleOperator: 'equals', Value: name });

    var de = DataExtension.Init(attr[0].CustomerKey);

    var fields = de.Fields.Retrieve();

    fields.sort(function (a, b) {
        return a.Ordinal > b.Ordinal ? 1 : -1;
    });

    var out = [];

    for (k in fields) {
        out = out.concat(fields[k].Name);
    }

    return out;
}

function retrieveAllRecords(name) {
    var prox = new Script.Util.WSProxy();

    var cols = retrieveFieldNames(name);

    var config = {
        name: name,
        cols: cols
    };

    var records = [],
        moreData = true,
        reqID = (data = null);

    while (moreData) {
        moreData = false;

        if (reqID == null) {
            data = prox.retrieve('DataExtensionObject[' + config.name + ']', config.cols);
        } else {
            data = prox.getNextBatch('DataExtensionObject[' + config.name + ']', reqID);
        }

        if (data != null) {
            moreData = data.HasMoreRows;
            reqID = data.RequestID;
            for (var i = 0; i < data.Results.length; i++) {
                var result_list = data.Results[i].Properties;
                var obj = {};
                for (k in result_list) {
                    var key = result_list[k].Name;
                    var val = result_list[k].Value;
                    if (key.indexOf('_') != 0) obj[key] = val;
                }
                records.push(obj);
            }
        }
    }
    return records;
}

function getRegion(mainStore) {
    var regionsNames, regions, europe, middleEast, us, china, apac, japan;
    europe = ['CH', 'CZ', 'DE', 'DK', 'ES', 'FR', 'GB', 'IE', 'IT', 'MC', 'NL', 'SE'];
    middleEast = ['AE', 'BH', 'KW', 'QA', 'SA'];
    us = ['CA', 'US'];
    china = ['CN'];
    apac = ['AU', 'HK', 'MA', 'SG', 'TH', 'TW'];
    japan = ['JP'];
    regions = [europe, middleEast, us, china, apac, japan];
    regionsNames = ['Europe', 'Middle East', 'US', 'China', 'APAC', 'Japan'];

    for (var i = 0, l = regions.length; i < l; i += 1) {
        for (var j = 0, k = regions[i].length; j < k; j += 1) {
            if (mainStore.indexOf(regions[i][j]) >= 0) return regionsNames[i];
        }
    }
    return 'Int';
}

function getCountry(mainStore) {
    var countryNames, countryCodes;
    countryNames = [
        'AE',
        'AU',
        'BH',
        'CA',
        'CH',
        'CN',
        'CZ',
        'DE',
        'DK',
        'ES',
        'FR',
        'GB',
        'HK',
        'IE',
        'IT',
        'JP',
        'KW',
        'MA006',
        'MA002',
        'MA005',
        'MA003',
        'MA901',
        'MA004',
        'MA001',
        'NL',
        'QA',
        'SA',
        'SE',
        'SG',
        'TH',
        'TW',
        'US'
    ];
    countryCodes = [
        'AE',
        'AU',
        'BH',
        'CA',
        'CH',
        'CN',
        'CZ',
        'DE',
        'DK',
        'ES',
        'FR',
        'GB',
        'HK',
        'IE',
        'IT',
        'JP',
        'KW',
        'MO',
        'MO',
        'MO',
        'MO',
        'MO',
        'MO',
        'MO',
        'NL',
        'QA',
        'SA',
        'SE',
        'SG',
        'TH',
        'TW',
        'US'
    ];
    for (var i = 0, l = countryNames.length; i < l; i += 1) {
        if (mainStore.indexOf(countryNames[i]) >= 0) return countryCodes[i];
    }
    return 'Int';
}

function getLanguage(writtenLanguage) {
    var langNames, langCodes;
    langNames = [
        'ARA',
        'CHS',
        'CHT',
        'CES',
        'NLD',
        'ENG',
        'VLS',
        'FRA',
        'GER',
        'ELL',
        'ITA',
        'JPN',
        'KOR',
        'POL',
        'POR',
        'RUS',
        'SPA',
        'SWE',
        'THA',
        'TUR'
    ];
    langCodes = [
        'en',
        'zhs',
        'en',
        'en',
        'en',
        'en',
        'en',
        'fr',
        'de',
        'en',
        'it',
        'ja',
        'en',
        'en',
        'en',
        'en',
        'es',
        'en',
        'en',
        'en'
    ];

    for (var i = 0, l = langNames.length; i < l; i += 1) {
        if (writtenLanguage.indexOf(langNames[i]) >= 0) return langCodes[i];
    }
    return 'en';
}
