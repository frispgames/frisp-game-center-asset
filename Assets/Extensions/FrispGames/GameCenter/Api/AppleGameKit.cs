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

		public void Initialize() {
			_Initialize ();
		}

		public void Authenticate() {
			_Authenticate ();
		}

		public bool Authenticated() {
			return _Authenticated ();
		}
	}
}
