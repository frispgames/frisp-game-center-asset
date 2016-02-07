using UnityEngine;
using System.Collections;
using FrispGames.GameCenter.Api;

namespace FrispGames
{
	namespace GameCenter {
		public class GameCenterManager : MonoBehaviour
		{

			void Awake () {
				if (Application.platform == RuntimePlatform.IPhonePlayer) {
					gameKit().Initialize ();
					gameKit().Authenticate ();
				}
			}

			public void ReportScore(long score)
			{
				if (Application.platform == RuntimePlatform.IPhonePlayer) {
					gameKit().ReportScore(score, this.LeaderboardId());
				}
			}

			public void ShowLeaderboard()
			{
				if (Application.platform == RuntimePlatform.IPhonePlayer) {
					gameKit().ShowLeaderboard(this.LeaderboardId());
				}
			}

			public void ReportAchievement(string achievementId, float percentageComplete) {
				if (Application.platform == RuntimePlatform.IPhonePlayer) {
					gameKit().ReportAchievement(achievementId, percentageComplete);
				}
			}
			
			private string LeaderboardId()
			{
				return ConfigurationManager.Instance().LeaderboardId();
			}

			private Api.AppleGameKit gameKit() {
				return Api.AppleGameKit.Instance ();
			}
		}
	}
}
