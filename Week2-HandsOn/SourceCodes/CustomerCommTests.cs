using NUnit.Framework;
using Moq;
using CustomerCommLib;

namespace CustomerComm.Tests
{
    [TestFixture] // Marks this class as a test suite
    public class CustomerCommTests
    {
        private Mock<IMailSender> _mockMailSender;
        private CustomerCommLib.CustomerComm _customerComm; // Fully qualify to avoid namespace/type ambiguity

        [OneTimeSetUp] // Runs once before all tests  
        public void Init()
        {
            _mockMailSender = new Mock<IMailSender>();

            // Configure the mock to return true for any two strings  
            _mockMailSender
                .Setup(sender => sender.SendMail(It.IsAny<string>(), It.IsAny<string>()))
                .Returns(true);

            // Inject mock into the class under test  
            _customerComm = new CustomerCommLib.CustomerComm(_mockMailSender.Object);
        }

        [TestCase] // Runs this test case with default setup  
        public void SendMailToCustomer_WhenCalled_ReturnsTrue()
        {
            // Act  
            bool result = _customerComm.SendMailToCustomer();

            // Assert  
            Assert.That(result, Is.True);
        }
    }
}
