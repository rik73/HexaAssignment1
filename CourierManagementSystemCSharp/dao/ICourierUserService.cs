using CourierManagementSystemC_.model;


namespace CourierManagementSystemC_.dao
{
    public interface ICourierUserService
    {
        public bool placeOrder(Courier newCourier);
        public string getOrderStatus(string trackingNumber);
        public bool cancelOrder(string  trackingNumber);

        public List<Courier> getAssignedOrder(int employeeID);
        List<Courier> GetallCouriers();
    }
}
