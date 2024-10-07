using CourierManagementSystemC_.util;
using CourierManagementSystemC_.model;
using CourierManagementSystemC_.exception;
using System.Data.SqlClient;

namespace CourierManagementSystemC_.dao
{
    public class CourierUserServiceImpl : ICourierUserService
    {
        private string _connectionString;
        public CourierUserServiceImpl()
        {
            _connectionString = DBConnUtil.GetConnString();
        }
        public List<Courier> GetallCouriers()
        {
            List<Courier> couriers = new List<Courier>();
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "select * from Courier";
                        cmd.Connection = connection;
                        connection.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            Courier courier = new Courier
                            (
                                Convert.ToInt32(reader["CourierID"]),
                                Convert.ToString(reader["SenderName"]),
                                Convert.ToString(reader["SenderAddress"]),
                                Convert.ToString(reader["ReceiverName"]),
                                Convert.ToString(reader["ReceiverAddress"]),
                                Convert.ToDouble(reader["Weight"]),
                                Convert.ToString(reader["Status"]),
                                Convert.ToString(reader["TrackingNumber"]),
                                Convert.ToDateTime(reader["DeliveryDate"]),
                                Convert.ToInt32(reader["EmployeeID"]),
                                Convert.ToInt32(reader["UserID"])
                            );
                            couriers.Add(courier);
                        }
                        connection.Close();
                    }
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine($"SQL Error: {ex.Message}");
                throw new Exception("Error while retrieving assets from the database.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"General Error: {ex.Message}");
                throw new Exception("An error occurred while retrieving assets.");
            }
            return couriers;
        }
        public bool placeOrder(Courier courier)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = @"INSERT INTO Courier 
                                       VALUES (@SenderName, @SenderAddress, @ReceiverName, 
                                               @ReceiverAddress, @Weight, @Status, 
                                               @TrackingNumber, @DeliveryDate,@EmployeeID, @UserId)";
                    cmd.Parameters.AddWithValue("@SenderName", courier.SenderName);
                    cmd.Parameters.AddWithValue("@SenderAddress", courier.SenderAddress);
                    cmd.Parameters.AddWithValue("@ReceiverName", courier.ReceiverName);
                    cmd.Parameters.AddWithValue("@ReceiverAddress", courier.ReceiverAddress);
                    cmd.Parameters.AddWithValue("@Weight", courier.Weight);
                    cmd.Parameters.AddWithValue("@Status", courier.Status);
                    cmd.Parameters.AddWithValue("@TrackingNumber", courier.TrackingNumber);
                    cmd.Parameters.AddWithValue("@DeliveryDate", courier.DeliveryDate);
                    cmd.Parameters.AddWithValue("@EmployeeId", courier.EmployeeID);
                    cmd.Parameters.AddWithValue("@UserId", courier.UserId);
                    cmd.Connection = connection;
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows > 0;
                }
            }
        }

        public string getOrderStatus(string trackingNumber)
        {

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "select Status from Courier where TrackingNumber=@TrackingNumber";
                    cmd.Parameters.AddWithValue("@TrackingNumber", trackingNumber);
                    cmd.Connection = connection;
                    connection.Open();
                    object result = cmd.ExecuteScalar();
                    if (result == null) throw new TrackingNumberNotFoundException();
                    return result.ToString(); // Return the status as a string
                }
            }
        }
        public bool cancelOrder(string trackingNumber)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "update Courier set Status='Order Cancelled' where TrackingNumber=@TrackingNumber";
                cmd.Parameters.AddWithValue("@trackingNumber", trackingNumber);
                cmd.Connection = connection;
                connection.Open();
                int rows = cmd.ExecuteNonQuery();
                if (rows == 0) throw new TrackingNumberNotFoundException();
                return rows > 0;
            }
        }

        public List<Courier> getAssignedOrder(int employeeID)
        {
            List<Courier> assignedOrders = new List<Courier>();
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "select * from Courier where EmployeeID=@EmployeeID";
                        cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
                        cmd.Connection = connection;
                        connection.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            Courier courier = new Courier
                            (
                                Convert.ToInt32(reader["CourierID"]),
                                Convert.ToString(reader["SenderName"]),
                                Convert.ToString(reader["SenderAddress"]),
                                Convert.ToString(reader["ReceiverName"]),
                                Convert.ToString(reader["ReceiverAddress"]),
                                Convert.ToDouble(reader["Weight"]),
                                Convert.ToString(reader["Status"]),
                                Convert.ToString(reader["TrackingNumber"]),
                                Convert.ToDateTime(reader["DeliveryDate"]),
                                Convert.ToInt32(reader["EmployeeID"]),
                                Convert.ToInt32(reader["UserId"])
                            );
                            assignedOrders.Add(courier);

                        }
                        connection.Close();
                    }
                }
            }
            catch (InvalidEmployeeIdException ex)
            {
                Console.WriteLine(ex.Message);
            }
            return assignedOrders;
        }



    }
}
