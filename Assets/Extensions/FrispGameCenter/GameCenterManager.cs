using UnityEngine;
using System.Collections;
using UnityEngine.SocialPlatforms;
using UnityEngine.SocialPlatforms.GameCenter;

namespace FrispGameCenter
{
	public class LeaderboardManager : MonoBehaviour
	{
		private ConfigurationManager _configManager;

		void Start ()
		{
			_configManager = new ConfigurationManager ();
			Social.localUser.Authenticate (success => {});
		}

		public void ReportScore(long score)
		{
			Social.Active.ReportScore (score, LeaderboardId(), success => {});
		}

		public void ShowLeaderboard()
		{
			Social.Active.ShowLeaderboardUI ();
		}
		
		private string LeaderboardId()
		{
			return _configManager.LeaderboardId();
		}
	}
}
