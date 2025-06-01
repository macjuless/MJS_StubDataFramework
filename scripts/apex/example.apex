/**
 * Example test class that uses the stubbing framework to test the selectByRouterAndVersionPositive method.
 */

@isTest
private class MJS_ApiInboundConfigurationsSelectorTest 
{
	@isTest
	static void selectByRouterAndVersionPositive() 
	{
		// GIVEN
		MJS_DataSelector selector = (MJS_DataSelector) MJS_StubDataMock.createMock(MJS_DataSelector.class);

		// WHEN
		Test.startTest();
		MJS_ApiInboundConfiguration__mdt result = selector.selectByRouterAndVersion('TestRouter', 'v1');
		Test.stopTest();

		// THEN
		System.Assert.isTrue(result.MJS_Status__c == 'Active', 'Status must be Active');
	}
}