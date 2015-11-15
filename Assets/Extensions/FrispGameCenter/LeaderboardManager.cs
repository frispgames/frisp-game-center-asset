using UnityEngine;
using System.Collections;
using UnityEngine.SocialPlatforms;
using UnityEngine.SocialPlatforms.GameCenter;

namespace FrispGameCenter
{
	public class LeaderboardManager : MonoBehaviour
	{
		private readonly ConfigurationManager _configManager = new ConfigurationManager ();

		void Start ()
		{
			Social.localUser.Authenticate (success => {});
		}

		public void ReportScore(long score)
		{
			Social.Active.ReportScore (score, LeaderboardId(), success => {});
		}

		public void ShowLeaderboard()
		{
			Social.ShowLeaderboardUI ();
		}
		
		private string LeaderboardId()
		{
			return _configManager.LeaderboardId();
		}
	}
}
