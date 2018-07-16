using UnityEngine;

public class LookAtPrinter : MonoBehaviour
{
	private void Update()
    {
        Debug.LogFormat("LookAt: {0}, LookUp: {1}",
            Utils.GetLookAt(transform.rotation),
            Utils.GetLookUp(transform.rotation));
	}
}
