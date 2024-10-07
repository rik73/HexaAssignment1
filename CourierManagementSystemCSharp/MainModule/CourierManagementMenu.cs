using CourierManagementSystemC_.dao;
using CourierManagementSystemC_.exception;
using CourierManagementSystemC_.model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CourierManagementSystemC_.MainModule
{
    public class CourierManagementMenu
    {

        private readonly ICourierUserService _courierService;

        public CourierManagementMenu()
        {
            // Instantiate the service implementation
            _courierService = new CourierUserServiceImpl();
        }
        public void DisplayMenu()
        {
            Console.WriteLine("Hey there! Welcome to Courier Management System");
            while (true)
            {
                Console.WriteLine("\nChoose An option");
                Console.WriteLine("1.To Place an Order");
                Console.WriteLine("2.To get Order Status");
                Console.WriteLine("3.To Cancel your Order Id");
                Console.WriteLine("4.Get Orders by Employee ID");
                Console.WriteLine("5.Display All Courier Table");
                Console.WriteLine("0. Exit");
                int choice = Convert.ToInt32(Console.ReadLine());
                switch (choice)
                {
                    case 1:
                        placeOrder();
                        break;

                    case 2:
                        getOrderStatus();
                        break;

                    case 3:
                        cancelOrder();
                        break;

                    case 4:
                        getAssignedOrder();
                        break;

                    case 5:
                        List<Courier> courierlist = _courierService.GetallCouriers();
                        foreach(Courier courier in courierlist)
                        {
                            Console.WriteLine(courier.ToString());
                        }
                        break;

                    case 6:
                        break;
                    case 0:
                        // Exit
                        return;

                    default:
                        Console.WriteLine("Invalid choice. Please choose again.");
                        break;
                }
            }
        }
        private void placeOrder()
        {
            Console.WriteLine("Enter sender name:");
            string senderName = Console.ReadLine();

            Console.WriteLine("Enter sender address:");
            string senderAddress = Console.ReadLine();

            Console.WriteLine("Enter receiver name:");
            string receiverName = Console.ReadLine();

            Console.WriteLine("Enter receiver address:");
            string receiverAddress = Console.ReadLine();

            Console.WriteLine("Enter weight:");
            double weight = Convert.ToDouble(Console.ReadLine());

            Console.WriteLine("Enter status:");
            string status = Console.ReadLine();

            Console.WriteLine("Enter Tracking Number:");
            string trackingNumber= Console.ReadLine();

            Console.WriteLine("Enter delivery date (yyyy-mm-dd):");
            DateTime deliveryDate = DateTime.Parse(Console.ReadLine());

            Console.WriteLine("Enter employee Id");
            int employeeId=Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("Enter user ID:");
            int userId = Convert.ToInt32(Console.ReadLine());
            Courier newCourier = new Courier
            {
                SenderName = senderName,
                SenderAddress=senderAddress,
                ReceiverName=receiverName,
                ReceiverAddress=receiverAddress,
                Weight=weight,
                Status=status,
                TrackingNumber=trackingNumber,
                DeliveryDate=deliveryDate,
                EmployeeID=employeeId,
                UserId=userId
            };
            bool queryStatus = _courierService.placeOrder(newCourier);
            Console.WriteLine(queryStatus ? "Order Placed Successfully" : "Failed to place order");
        }
        private void getOrderStatus() 
        {
            try
            {
                Console.WriteLine("Enter Tracking Number");
                string trackingNumber = Console.ReadLine();
                string orderStatus = _courierService.getOrderStatus(trackingNumber);
                Console.WriteLine($"The status of the order with tracking number {trackingNumber} is: {orderStatus}");
            }
            catch (TrackingNumberNotFoundException ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
        private void cancelOrder() 
        {
            try
            {
                Console.WriteLine("Enter Tracking Number of the order you want to Cancel");
                string trackingNumber = Console.ReadLine();
                bool ordersCancelled = _courierService.cancelOrder(trackingNumber);
                Console.WriteLine(ordersCancelled ? $"{ordersCancelled}Order has been cancelled successfully" : "Failed to Cancel");
            }
            catch (TrackingNumberNotFoundException ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
        private void getAssignedOrder() 
        {
            Console.WriteLine("Enter Employee ID");
            int employeeID=int.Parse(Console.ReadLine());
            List<Courier> assignedOrders = _courierService.getAssignedOrder(employeeID);
            if (assignedOrders.Count > 0)
            {
                Console.WriteLine($"Orders assigned to staff ID {employeeID}:");
                foreach (var order in assignedOrders)
                {
                    Console.WriteLine($"Tracking Number: {order.TrackingNumber}, Status: {order.Status}, Delivery Date: {order.DeliveryDate}");
                }
            }
            else
            {
                Console.WriteLine("No orders assigned to this staff member.");
            }

        }

    }
}
