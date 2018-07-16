using UnityEngine;

public static class Utils
{
    public static Vector3 GetLookAt(Quaternion rotation)
    {
        return rotation * new Vector3(0.0f, 0.0f, 1.0f);
    }

    public static Vector3 GetLookUp(Quaternion rotation)
    {
        return rotation * new Vector3(0.0f, 1.0f, 0.0f);
    }
}
