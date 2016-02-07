using UnityEngine;
using System.Collections;

namespace FrispGames.GameCenter {
	public class ConfigurationManager {
		private readonly Configuration _config;
		private static readonly ConfigurationManager _singleton = new ConfigurationManager ();
		
		private ConfigurationManager() {
			this._config = Resources.Load<Configuration>("FrispGames/GameCenter/Configuration");
		}
		
		public static ConfigurationManager Instance() {
			return _singleton;
		}

		public string LeaderboardId(){
			if (Application.platform == RuntimePlatform.IPhonePlayer) {
				return this._config.AppleGameCenterLeaderboardId;
			} else {
				// Don't know what to do so return empty string
				return "";
			}
		}
	}
}
