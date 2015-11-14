using UnityEngine;
using System.Collections;
using UnityEngine.SocialPlatforms;
using UnityEngine.SocialPlatforms.GameCenter;

public class LeaderboardManager : MonoBehaviour {

	void Start () {
		Social.localUser.Authenticate (success => {});
	}

	public void ReportScore(long score) {
		Social.Active.ReportScore (score, LeaderboardId(), success => {});
	}

	public void ShowLeaderboard(){
		Social.ShowLeaderboardUI ();
	}
	
	private string LeaderboardId() {
		return "frispgamecenterasset";
	}
}
