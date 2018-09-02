/*
 *   __  ____  _ __
 *  / / / / /_(_) /__
 * / /_/ / __/ / (_-<
 * \____/\__/_/_/___/
 *
 * Utils & Extensions for Swiift Projects..
 * Written by Ciathyza
 */

import Foundation


///
/// Provides JSON util methods.
///
class JSON
{
	/// Encodes and writes data to a JSON file.
	///
	/// - Parameters:
	/// 	- obj: data to serialize.
	/// 	- path: File path.
	///
	/// - Returns: true if successful.
	///
	public static func encodeAndWriteToStream<T:Encodable>(_ obj:T, path:String) -> Bool
	{
		if let encodedData = try? JSONEncoder().encode(obj)
		{
			do
			{
				try encodedData.write(to: URL(fileURLWithPath: path), options: .atomic)
			}
			catch
			{
				Log.error("Failed to write JSON data [\(encodedData)] to \"\(path)\".")
				return false
			}
		}
		return true
	}
	
	
	/// Encodes a codable object to a JSON string.
	///
	/// - Parameters:
	/// 	- obj: Object that needs to conform to Codable.
	///
	/// - Returns: A JSON Data or nil.
	///
	public static func encode<T:Encodable>(_ obj:T) -> Data?
	{
		if let encodedData = try? JSONEncoder().encode(obj)
		{
			return encodedData
		}
		Log.error("Failed to encode \(obj).")
		return nil
	}
	
	
	/// Encodes a codable object to a JSON string.
	///
	/// - Parameters:
	/// 	- obj: Object that needs to conform to Codable.
	///
	/// - Returns: A JSON string or nil.
	///
	public static func encodeToString<T:Encodable>(_ obj:T) -> String?
	{
		if let data = JSON.encode(obj)
		{
			return String(data: data, encoding: .utf8)
		}
		return nil
	}
	
	
	/// Serializes and writes data to a JSON file.
	///
	/// - Parameters:
	/// 	- data: data to serialize.
	/// 	- path: File path.
	///
	/// - Returns: true if successful.
	///
	public static func writeToStream(data:Any, path:String) -> Bool
	{
		var success = false
		if JSONSerialization.isValidJSONObject(data)
		{
			if let stream = OutputStream(toFileAtPath: "\(path)", append: false)
			{
				stream.open()
				var error:NSError?
				JSONSerialization.writeJSONObject(data, to: stream, options: [], error: &error)
				stream.close()
				if let error = error
				{
					Log.error("Failed to write JSON data: \(error.localizedDescription)")
					success = false
				}
			}
			else
			{
				Log.error("Could not open JSON file stream at \(path).")
				success = false
			}
		}
		else
		{
			Log.error("Data is not a valid format for JSON serialization: \(data)")
			success = false
		}
		return success
	}
	
	
	/// Serializes a Serpent-serializable data strcture to JSON.
	///
	/// - Parameters:
	/// 	- data: Data to serialize.
	///
	/// - Returns: A Data? object.
	///
	public static func serialize(data:Any) -> Data?
	{
		if JSONSerialization.isValidJSONObject(data)
		{
			var json:Data?
			var success = true
			
			do
			{
				json = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
			}
			catch
			{
				Log.error("Failed to serialize JSON data: \(data)")
				success = false
			}
			
			if (success && json != nil)
			{
				let jsonString = String.init(data: json!, encoding: .utf8)!
				return jsonString.data(using: .ascii, allowLossyConversion: true)
			}
		}
		else
		{
			Log.error("Data is not a valid format for JSON serialization: \(data)")
		}
		return nil
	}
	
	
	/// Deserializes given JSON data to a [String:Any] dictionary.
	///
	/// - Parameters:
	/// 	- data: Data to deserialize.
	///
	/// - Returns: A dictionary of [String:Any].
	///
	public static func deserialize(data:Data) -> [String:Any]
	{
		do
		{
			if let deserializedData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
			{
				return deserializedData
			}
		}
		catch
		{
			Log.error("Failed to deserialize JSON data: \(data).")
		}
		return [String:Any]()
	}
}
