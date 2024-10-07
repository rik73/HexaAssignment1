using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CourierManagementSystemC_.model
{
    public class Courier
    {
        public int CourierID { get; set; }
        public string SenderName { get; set; }
        public string SenderAddress { get; set; }
        public string ReceiverName { get; set; }
        public string ReceiverAddress { get; set; }
        public double Weight { get; set; }
        public string Status { get; set; }
        public string TrackingNumber { get; set; }
        public DateTime? DeliveryDate { get; set; }

        public int EmployeeID { get; set; }
        public int UserId { get; set; }


        public Courier() { }
        public Courier(int courierID, string senderName, string senderAddress, string receiverName, string receiverAddress, double weight, string status, string trackingNumber, DateTime deliveryDate, int employeeID, int userId)
        {
            CourierID = courierID;
            SenderName = senderName;
            ReceiverName = senderAddress;
            ReceiverAddress = receiverName;
            Weight = weight;
            Status = status;
            TrackingNumber = trackingNumber;
            DeliveryDate = deliveryDate;
            EmployeeID = employeeID;
            UserId = userId;

        }

        public override string ToString()
        {
            return $"Courier ID: {CourierID} SenderName:{SenderName} SenderAddress:{SenderAddress} ReceiverName:{ReceiverName} ReceiverAddress:{ReceiverAddress} Weight:{Weight}Kgs Status:{Status} TrackingNumber:{TrackingNumber} DeliveryDate:{DeliveryDate} EmployeeID:{EmployeeID} UserID:{UserId}";
        }
    }
}
