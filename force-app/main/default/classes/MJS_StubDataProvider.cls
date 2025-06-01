
@IsTest
public without sharing class MJS_StubDataProvider implements System.StubProvider
{
	private final static String CLASS_NAME_MARKER = '__sfdc_';

	/**
	 * @description This method is called by the Test.createStub() API to handle method calls on the stubbed object.
	 * 				It retrieves the stub data from the custom metadata type MJS_StubData__mdt based on the parameters
	 * 				provided and returns the corresponding value that is then deserialized to the expected return type.
	 */
	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) 
	{
		// Convert everything to string for easier comparison
		string className = stubbedObject.toString().left(stubbedObject.toString().indexOf(CLASS_NAME_MARKER));
		string returnTypeName = returnType.toString();
		string listOfParamTypeValues = listOfParamTypes.toString();
		string listOfParamNameValues = JSON.serialize(listOfParamNames);
		string listOfArgValues = JSON.serialize(listOfArgs);

		// System.debug('---');
		// System.debug('Stubbed Object: ' 		+ className);
		// System.debug('Stubbed Method Name: ' + stubbedMethodName);
		// System.debug('Return Type: ' 		+ returnTypeName);
		// System.debug('List of Param Types: ' + listOfParamTypeValues);
		// System.debug('List of Param Names: ' + listOfParamNameValues);
		// System.debug('List of Args: ' 		+ listOfArgValues);
		// System.debug('---');

		/**
		 * IMPORTANT
		 * The framework assumes that entries in the MJS_StubData__mdt custom metadata type are unique based on the combination of the following fields:
		 *   - MJS_StubbedObject__c
		 *   - MJS_StubbedMethodName__c
		 *   - MJS_ReturnType__c
		 *   - MJS_ListOfParamTypes__c
		 *   - MJS_ListOfParamNames__c
		 *   - MJS_ListOfArgs__c
		 */
		if(	String.isNotBlank(className) && 
			String.isNotBlank(stubbedMethodName) && 
			String.isNotBlank(returnTypeName) && 
			String.isNotBlank(listOfParamTypeValues) && 
			String.isNotBlank(listOfParamNameValues) && 
			String.isNotBlank(listOfArgValues))
		{
			List<MJS_StubData__mdt> results = [	SELECT	MJS_Value__c 
												FROM	MJS_StubData__mdt 
												WHERE	MJS_StubbedObject__c = :className AND 
														MJS_StubbedMethodName__c = :stubbedMethodName AND 
														MJS_ReturnType__c = :returnTypeName AND 
														MJS_ListOfParamTypes__c = :listOfParamTypeValues AND 
														MJS_ListOfParamNames__c = :listOfParamNameValues AND 
														MJS_ListOfArgs__c = :listOfArgValues];
			if(results.size() > 0)
			{
				return JSON.deserialize(results[0].MJS_Value__c, returnType);
			}
		}

		return null;
	}
}