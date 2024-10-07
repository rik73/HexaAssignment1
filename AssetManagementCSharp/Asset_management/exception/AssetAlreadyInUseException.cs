using System.Runtime.Serialization;

namespace DigitalAssetManagement.exception
{
    [Serializable]
    internal class AssetAlreadyInUseException : Exception
    {
        public AssetAlreadyInUseException()
        {
        }

        public AssetAlreadyInUseException(string? message) : base(message)
        {
        }

        public AssetAlreadyInUseException(string? message, Exception? innerException) : base(message, innerException)
        {
        }

        
    }
}