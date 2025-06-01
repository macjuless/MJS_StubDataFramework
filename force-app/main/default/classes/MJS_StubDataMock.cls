@IsTest
public with sharing class MJS_StubDataMock 
{
	private MJS_StubDataMock() { }

	public static MJS_StubDataProvider getInstance() 
	{
		return new MJS_StubDataProvider();
	}
	
	public static Object createMock(Type typeToMock) 
	{
		// Invoke the stub API and pass it our mock provider to create a mock class of typeToMock.
		return Test.createStub(typeToMock, MJS_StubDataMock.getInstance());
	}
}