using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using DigitalAssetManagement.exception;
using DigitalAssetManagement.model;
using DigitalAssetManagement.util;

namespace DigitalAssetManagement.dao
{
    public class AssetManagementServiceImpl : IAssetManagementService
    {
        private string _connectionString;
        public AssetManagementServiceImpl()
        {
            _connectionString = DBConnectionUtil.GetConnString();
        }

        public List<Asset> GetallAssets()
        {
            List<Asset> assets = new List<Asset>();
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "select * from assets";
                        cmd.Connection = connection;
                        connection.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            Asset asset = new Asset
                            (
                                 Convert.ToInt32(reader["asset_id"]),
                                 Convert.ToString(reader["name"]),
                                 Convert.ToString(reader["type"]),
                                 Convert.ToString(reader["serial_num"]),
                                 Convert.ToDateTime(reader["purchase_date"]),
                                 Convert.ToString(reader["location"]),
                                 Convert.ToString(reader["status"]),
                                 Convert.ToInt32(reader["owner_id"])
                            );
                            assets.Add(asset);
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
            return assets;
        }


        public List<Asset> GetAvailableAssets()
        {
            List<Asset> availableAssets = new List<Asset>();
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "select * from Assets where status = 'available'";
                        cmd.Connection = connection;
                        connection.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            Asset asset = new Asset
                            (
                                Convert.ToInt32(reader["asset_id"]),
                                Convert.ToString(reader["name"]),
                                Convert.ToString(reader["type"]),
                                Convert.ToString(reader["serial_num"]),
                                Convert.ToDateTime(reader["purchase_date"]),
                                Convert.ToString(reader["location"]),
                                Convert.ToString(reader["status"]),
                                Convert.ToInt32(reader["owner_id"])
                            );
                            availableAssets.Add(asset);
                        }
                        connection.Close();
                    }
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine($"SQL Error: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"General Error: {ex.Message}");
            }
            return availableAssets;
        }

        public bool AddAsset(Asset asset)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "Insert into Assets values(@name,@type,@serial_num, @purchase_date, @location, @status, @owner_id)";


                    cmd.Parameters.AddWithValue("@name", asset.Name);
                    cmd.Parameters.AddWithValue("@type", asset.Type);
                    cmd.Parameters.AddWithValue("@serial_num", asset.SerialNumber);
                    cmd.Parameters.AddWithValue("@purchase_date", asset.PurchaseDate);
                    cmd.Parameters.AddWithValue("@location", asset.Location);
                    cmd.Parameters.AddWithValue("@status", asset.Status);
                    cmd.Parameters.AddWithValue("@owner_Id", asset.OwnerId);
                    cmd.Connection = connection;
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows > 0;
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine($"Database error: {ex.Message}");
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
                return false;
            }
        }

        public bool UpdateAsset(Asset asset)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "update Assets set name = @name, type = @type, serial_num = @serial_num,purchase_date = @purchase_date, location = @location, status = @status, owner_id = @owner_id where asset_id = @asset_id";

                    cmd.Parameters.AddWithValue("@name", asset.Name);
                    cmd.Parameters.AddWithValue("@type", asset.Type);
                    cmd.Parameters.AddWithValue("@serial_num", asset.SerialNumber);
                    cmd.Parameters.AddWithValue("@purchase_date", asset.PurchaseDate);
                    cmd.Parameters.AddWithValue("@location", asset.Location);
                    cmd.Parameters.AddWithValue("@status", asset.Status);
                    cmd.Parameters.AddWithValue("@owner_id", asset.OwnerId);
                    cmd.Parameters.AddWithValue("@asset_id", asset.AssetId);
                    cmd.Connection = connection;
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    if (rows == 0)
                    {
                        throw new AssetNotFoundException("Asset not found or could not be updated.");
                    }
                    return rows > 0;
                }
            }
            catch (AssetNotFoundException ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
            catch (SqlException ex)
            {
                Console.WriteLine($"Database error: {ex.Message}");
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
                return false;
            }
        }

         public bool DeleteAsset(int assetId)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "delete from Assets where asset_id=@asset_id";
                    cmd.Parameters.AddWithValue("@asset_id", assetId);
                    cmd.Connection = connection;
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    if (rows == 0)
                    {
                        throw new AssetNotFoundException("Asset not found or deleted.");
                    }
                    connection.Close();
                    return rows > 0;
                }
            }
            catch (AssetNotFoundException ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
            catch (SqlException ex)
            {
                Console.WriteLine($"Database error: {ex.Message}");
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
                return false;
            }
        }

        public bool AllocateAsset(int assetId, int employeeId, string allocationDate, string returnDate)
        {

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                SqlCommand checkStatusCmd = new SqlCommand(
                    "SELECT status FROM assets WHERE asset_id = @asset_id", connection);
                checkStatusCmd.Parameters.AddWithValue("@asset_id", assetId);
                string status = (string)checkStatusCmd.ExecuteScalar();
                if (status == "in use")
                {
                    throw new InvalidOperationException("The asset is already in use and cannot be allocated.");
                }
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "INSERT INTO asset_allocations (asset_id, employee_id, allocation_date, return_date) VALUES (@asset_id, @employee_id, @allocation_date, @return_date)";

                cmd.Parameters.AddWithValue("@asset_id", assetId);
                cmd.Parameters.AddWithValue("@employee_id", employeeId);
                cmd.Parameters.AddWithValue("@allocation_date", DateTime.Parse(allocationDate));
                cmd.Parameters.AddWithValue("@return_date", DateTime.Parse(returnDate));
                cmd.Connection = connection;
                int rows = cmd.ExecuteNonQuery();
                cmd.CommandText = "UPDATE assets SET status = 'in use' WHERE asset_id = @asset_id";
                cmd.ExecuteNonQuery();
                return rows > 0;
            }

        }

        public bool DeallocateAsset(int assetId, int employeeId, string returnDate)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "delete from asset_allocations values(@asset_id,@employee_id,@allocation_date,@return_date)";
                cmd.CommandText = "update assets set status='available' where asset_id=@asset_id";
                cmd.Parameters.AddWithValue("@asset_id", assetId);
                cmd.Parameters.AddWithValue("@employee_id", employeeId);
                cmd.Parameters.AddWithValue("@return_date", returnDate);
                cmd.Connection = connection;
                connection.Open();
                int rows = cmd.ExecuteNonQuery();

                return rows > 0;
            }
        }

        public bool PerformMaintenance(int assetId, string maintenanceDate, string description, double cost)
        {

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Insert into maintenance values (@asset_id,@maintenance_date,@description,@cost)";
                cmd.Parameters.AddWithValue("@asset_id", assetId);
                cmd.Parameters.AddWithValue("@maintenance_date", DateTime.Parse(maintenanceDate));
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@cost", cost);
                cmd.Connection = connection;
                connection.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }


        }

        public bool ReserveAsset(int assetId, int employeeId, string reservationDate, string startDate, string endDate, string status)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "insert into reservations values(@asset_id, @employee_id, @reservation_date, @start_date, @end_date,@status)";

                cmd.Parameters.AddWithValue("@asset_id", assetId);
                cmd.Parameters.AddWithValue("@employee_id", employeeId);
                cmd.Parameters.AddWithValue("@reservation_date", DateTime.Parse(reservationDate));
                cmd.Parameters.AddWithValue("@start_date", DateTime.Parse(startDate));
                cmd.Parameters.AddWithValue("@end_date", DateTime.Parse(endDate));
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Connection = connection;
                connection.Open();
                SqlCommand statusCheckCmd = new SqlCommand("SELECT status FROM assets WHERE asset_id=@asset_id", connection);
        statusCheckCmd.Parameters.AddWithValue("@asset_id", assetId);

        string currentStatus = (string)statusCheckCmd.ExecuteScalar();

        // Throw exception if status is "in use"
        if (currentStatus == "in use" && status=="approved")
        {
            throw new AssetAlreadyInUseException("Cannot reserve the asset because it is currently in use.");
        }
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        public bool WithdrawReservation(int reservationId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "update reservations set status = 'canceled' where reservation_id = @reservation_id";
                cmd.Parameters.AddWithValue("@reservation_id", reservationId);
                cmd.Connection = connection;
                connection.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

    }
}
