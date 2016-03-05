using UnityEngine;
using UnityEditor;

namespace FrispGames.GameCenter {
	public class ConfigurationAsset
	{
		#if UNITY_EDITOR
		[MenuItem("Assets/Create/Configuration")]
		public static void Create() {
			string assetPathAndName =
				AssetDatabase.GenerateUniqueAssetPath("Assets/Configuration.asset");
			
			var asset = ScriptableObject.CreateInstance<FrispGames.GameCenter.Configuration>();
			AssetDatabase.CreateAsset(asset, assetPathAndName);
			
			AssetDatabase.SaveAssets();
			AssetDatabase.Refresh();
		}
		#endif
	}
}
