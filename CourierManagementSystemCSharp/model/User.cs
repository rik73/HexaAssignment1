using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CourierManagementSystemC_.model
{
    public class User
    {
        public int UserID { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string ContactNumber { get; set; }
        public string Address { get; set; }
        public User() { }

        public User(int userID, string userName, string email, string password, string contactNumber, string address)
        {
            UserID = userID;
            UserName = userName;
            Email = email;
            Password = password;
            ContactNumber = contactNumber;
            Address = address;
        }

        public override string ToString()
        {
            return $"User ID :{UserID}\tUserName:{UserName}\tEmail:{Email}\tPassword:{Password}\tContactNumber:{ContactNumber}" +
                $"\tAddress{Address}";
        }
    }
}
