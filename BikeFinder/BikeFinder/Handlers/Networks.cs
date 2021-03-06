﻿using System.Collections.Generic;
using System.Threading.Tasks;
using System.Diagnostics;
using System;
using System.Linq;
using Xamarin.Forms.Maps;

namespace BikeFinder
{
	public class Networks
	{
		static Networks instance;

		Networks ()
		{
		}

		public static Networks Instance {
			get {
				if (instance == null) {
					instance = new Networks ();
				}
				return instance;
			}
		}

		public Dictionary<double, Network> DistanceNetworks { get; set; }

		public Network ClosestNetwork {
			get { 
				if (DistanceNetworks != null) {
					var distance = DistanceNetworks.Keys.ToList ();
					distance.Sort ();
                    Debug.WriteLine(distance[0]);
                    Debug.WriteLine(DistanceNetworks[distance[0]].city);
					return DistanceNetworks [distance [0]];
				}
				return null;
			}
		}

		public List<Network> NetworkList { get; set; }

		public Network CurrentNetwork { get; set; }

		public async Task<bool> GetNetworks ()
		{
			NetworkList = await NetworksController.Instance.GetNetworks ();
			//foreach (var i in NetworkList)
			//{
				
			//	Debug.WriteLine("URL" + i.url);
			//	var c = await CityController.Instance.GetCityData(i.url);
			//	Debug.WriteLine("Count " + c.Count);
				
			//}
			return NetworkList !=null && NetworkList.Count >= 1;
		}

		public async Task<bool> CalculateNetworkDistance ()
		{
			if (null == DistanceNetworks) {
				DistanceNetworks = new Dictionary<double,Network> ();
			}
			try{
			foreach (var network in NetworkList) {
                    var sd = new Common.Coordinates(network.lat / 1E6, network.lng / 1E6);
                    var td = new Common.Coordinates(LocationHandler.Instance.CurrentLocation.Latitude, LocationHandler.Instance.CurrentLocation.Longitude);
                    var n = Common.DistanceBetween.DistanceTo(sd, td,Common.UnitOfLength.Kilometers);
				//var n = Math.Abs (((network.lat / 1E6) - LocationHandler.Instance.CurrentLocation.Latitude) + ((network.lng / 1E6) - LocationHandler.Instance.CurrentLocation.Longitude));
                    Debug.WriteLine(network.city + " " + n.ToString());

                    if (DistanceNetworks.ContainsKey (n)) {
					DistanceNetworks [n] = network;
				} else {
					DistanceNetworks.Add (n, network);
				}
			}
				return true;
			} catch {
				return false;
			}
		}

	}
}

