using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace CourierManagementSystemC_.model
{
    class Payment
    {
        public long PaymentID { get; set; } 
        public long CourierID {  get; set; }
        public long Amount {  get; set; }
        public DateTime PaymentDate {  get; set; }
        public Payment(long paymentID,long courierID,long amount,DateTime paymentdate)
        {
            PaymentID = paymentID;
            CourierID = courierID;
            Amount = amount;
            PaymentDate = paymentdate;
        }

        public override string ToString()
        {
            return $"PaymentID: {PaymentID}, CourierID: {CourierID}, Amount: {Amount}, PaymentDate: {PaymentDate}";
        }
    }
}
