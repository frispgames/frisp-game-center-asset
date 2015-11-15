using UnityEngine;
using System.Collections;

namespace FrispGameCenter
{
	public class ConfigurationManager : MonoBehaviour
	{
		private readonly Configuration _config;

		public ConfigurationManager ()
		{
			this._config = Resources.Load<Configuration>("FrispGameCenter/Configuration");
		}

		public string LeaderboardId()
		{
			if (Application.platform == RuntimePlatform.Android) {
				return this._config.GoogleGameServicesLeaderboardId;
			} else if (Application.platform == RuntimePlatform.IPhonePlayer) {
				return this._config.AppleGameCenterLeaderboardId;
			} else {
				// Don't know what to do so return empty string
				return "";
			}
		}
	}
}
