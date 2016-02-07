using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace FrispGames.GameCenter.Api {
	public class AppleGameKit : MonoBehaviour  {
		[DllImport ("__Internal")]
		private static extern void _Initialize ();

		[DllImport ("__Internal")]
		private static extern void _Authenticate ();

		[DllImport ("__Internal")]
		private static extern bool _Authenticated ();

		[DllImport ("__Internal")]
		private static extern bool _ReportScore (long score, string leaderboardId);

		[DllImport ("__Internal")]
		private static extern bool _ReportAchievement (string achievementId, float percentageComplete);

		[DllImport ("__Internal")]
		private static extern bool _ShowLeaderboard (string leaderboardId);

		private static readonly AppleGameKit _singleton = new AppleGameKit ();
		
		private AppleGameKit() {}
		
		public static AppleGameKit Instance() {
			return _singleton;
		}
		
		public void Initialize() {
			_Initialize ();
		}

		public void Authenticate() {
			_Authenticate ();
		}

		public bool Authenticated() {
			return _Authenticated ();
		}

		public void ReportScore(long score, string leaderboardId) {
			_ReportScore (score, leaderboardId);
		}

		public void ReportAchievement(string achievementId, float percentageComplete) {
			_ReportAchievement (achievementId, percentageComplete);
		}

		public void ShowLeaderboard(string leaderboardId) {
			_ShowLeaderboard (leaderboardId);
		}
	}
}
