var reporter = require('cucumber-html-reporter');

var options = {
        theme: 'hierarchy',
        jsonFile: 'cypress/cucumber-json',
        output: './report/cucumber_report.html',
        reportSuiteAsScenarios: true,
        scenarioTimestamp: true,
        launchReport: true,
        metadata: {
            "App Version":"0.3.2",
            "Test Environment": "STAGING",
            "Browser": "Chrome  90.0.4430.93",
            "Platform": "MacOS",
            "Parallel": "Scenarios",
            "Executed": "Remote"
        }
    };

    reporter.generate(options);
