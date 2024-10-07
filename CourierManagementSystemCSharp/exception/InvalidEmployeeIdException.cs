using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CourierManagementSystemC_.exception
{
    public class InvalidEmployeeIdException:Exception
    {
        public InvalidEmployeeIdException() : base("Employee Not Found/Employee Has not been alloted any assets") { }

        public InvalidEmployeeIdException(string message) : base(message) { }

        public InvalidEmployeeIdException(string message, Exception inner) : base(message, inner) { }
    }
}
