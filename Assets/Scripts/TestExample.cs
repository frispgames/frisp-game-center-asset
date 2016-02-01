using UnityEngine;
using System.Collections;

public class TestExample : MonoBehaviour
{
	public void ReportScore()
	{
		FrispGameCenter.GameCenterManager mgr = gameObject.GetComponent<FrispGameCenter.GameCenterManager>();
		mgr.ReportScore (100);
	}

	public void RestartGame()
	{
		Application.LoadLevel (0);
	}
}
