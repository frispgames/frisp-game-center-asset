using UnityEngine;
using System.Collections;

public class TestExample : MonoBehaviour
{
	private FrispGames.GameCenter.GameCenterManager _gameCenterManager;

	void Awake() {
		_gameCenterManager = new FrispGames.GameCenter.GameCenterManager ();
	}

	public void ReportScore () {
		_gameCenterManager.ReportScore (200);
	}

	public void ReportAchievement () {
		_gameCenterManager.ReportAchievement ("com.frispgames.frispgamecenterasset.achievement_1", 100.0f);
	}

	public void ShowLeaderboard () {
		_gameCenterManager.ShowLeaderboard ();
	}

	public void RestartGame()
	{
		Application.LoadLevel (0);
	}
}
