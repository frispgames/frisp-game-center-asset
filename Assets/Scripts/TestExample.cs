using UnityEngine;
using System.Collections;

public class TestExample : MonoBehaviour {

	public void ReportScore() {
		LeaderboardManager mgr = gameObject.GetComponent<LeaderboardManager>();
		mgr.ReportScore (100);
	}
}
