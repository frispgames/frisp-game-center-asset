using UnityEngine;
using System.Collections;

public class TestExample : MonoBehaviour
{
	public void ReportScore()
	{
		FrispGameCenter.LeaderboardManager mgr = gameObject.GetComponent<FrispGameCenter.LeaderboardManager>();
		mgr.ReportScore (100);
	}

	public void RestartGame()
	{
		Application.LoadLevel (0);
	}
}
