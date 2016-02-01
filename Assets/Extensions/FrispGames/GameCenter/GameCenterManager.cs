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
				this._configManager = new ConfigurationManager ();

				if (Application.platform == RuntimePlatform.IPhonePlayer) {
					_appleGameKit = new Api.AppleGameKit ();
					_appleGameKit.Initialize ();
					_appleGameKit.Authenticate ();
				}
			}

			public void ReportScore(long score)
			{
				if (Application.platform == RuntimePlatform.IPhonePlayer) {
					_appleGameKit.ReportScore(score, LeaderboardId());
				}
			}

			public void ShowLeaderboard()
			{
				if (Application.platform == RuntimePlatform.IPhonePlayer) {
					_appleGameKit.ShowLeaderboard(this.LeaderboardId());
				}
			}

			public void ReportAchievement(string achievementId, float percentageComplete) {
				if (Application.platform == RuntimePlatform.IPhonePlayer) {
					_appleGameKit.ReportAchievement(achievementId, percentageComplete);
				}
			}
			
			private string LeaderboardId()
			{
				return _configManager.LeaderboardId();
			}
		}
	}
}
