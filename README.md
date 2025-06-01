# Stub Data Framework

This is small, reusable stubbing framework that leverages Salesforce's Stub API. For more information about the baseline implementation of this solution, see [Stub API](https://developer.salesforce.com/docs/atlas.en-us.256.0.apexcode.meta/apexcode/apex_testing_stub_api.htm). 

## Usage

Create a CMT record that represents a combination of stubbed parameters including:

1. stubbedObject
2. stubbedMethodName
3. returnType
4. listOfParamTypes
5. listOfParamNames
6. listOfArgs

and a serialised version of a record to return in JSON format. If all the conditions above are met, the framework will cast the JSON value into an object using the value of the returnType parameter.

In the example below...

```
public with sharing class TestSelector 
{
	public MJS_Configuration__mdt selectByNameAndVersion(string configName, string version)
	{
		...
		return (MJS_Configuration__mdt) a;
	}
}

@isTest
private class TestSelector 
{
	@isTest
	static void selectByRouterAndVersionPositive() 
	{
		// GIVEN
		TestSelector se = (TestSelector) MJS_StubDataMock.createMock(TestSelector.class);

		// WHEN
		Test.startTest();
		MJS_Configuration__mdt result = se.selectByNameAndVersion('TestRouter', 'v1');
		Test.stopTest();

		// THEN
		System.Assert.isTrue(result.MJS_Status__c == 'Active', 'Status must be Active');
	}
}
```

We can create the following a stubbed CMT record with the following values:

```
MJS_StubbedObject__c = 'TestSelector';
MJS_StubbedMethodName__c = 'selectByNameAndVersion';
MJS_ReturnType__c = 'MJS_Configuration__mdt';
MJS_ListOfParamTypes__c = '(String, String)';
MJS_ListOfParamNames__c = '["configName","version"]';
MJS_ListOfArgs__c = '["TestRouter","v1"]';
MJS_Value__c = '{"MJS_Status__c":"Active"}';
```

## License

[MIT](https://choosealicense.com/licenses/mit/)