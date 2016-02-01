using UnityEngine;
using System.Collections;

namespace FrispGames
{
	namespace GameCenter {
		public class GameCenterManager : MonoBehaviour
		{
			private ConfigurationManager _configManager;
			private Api.AppleGameKit _appleGameKit;

			void Awake () {
				_configManager = new ConfigurationManager ();

				if (Application.platform == RuntimePlatform.IPhonePlayer) {
					_appleGameKit = new Api.AppleGameKit ();
					_appleGameKit.Initialize ();
					_appleGameKit.Authenticate ();
				}
			}

			public void ReportScore(long score)
			{
			}

			public void ShowLeaderboard()
			{
			}
			
			private string LeaderboardId()
			{
				return _configManager.LeaderboardId();
			}
		}
	}
}
