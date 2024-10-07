using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CourierManagementSystemC_.model
{
    class Employee
    {
        public int EmployeeID {  get; set; }
        public string EmployeeName {  get; set; }
        public string Email {  get; set; }
        public string ContactNumber {  get; set; }
        public string Role {  get; set; }
        public double Salary {  get; set; }
        public Employee(int employeeID, string employeeName, string email, string contactNumber, string role, double salary)
        {
            EmployeeID = employeeID;
            EmployeeName = employeeName;
            Email = email;
            ContactNumber = contactNumber;
            Role = role;
            Salary = salary;
        }
        public override string ToString()
        {
            return $"Employee ID: {EmployeeID}, Name: {EmployeeName}, Role: {Role}, Salary: {Salary}";
        }
    }
}
    
