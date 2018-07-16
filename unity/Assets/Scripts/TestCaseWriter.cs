using System.IO;
using UnityEngine;

public class TestCaseWriter : MonoBehaviour
{
    private string filePath = "../test_case.txt";

    private void Start ()
    {
        using(StreamWriter writer = new StreamWriter(filePath, true))
        {
            for(int i = 0; i < 10000; ++i)
            {
                transform.localRotation = Random.rotationUniform;
                var quaternion = transform.localRotation;
                var euler = transform.localEulerAngles;
                var lookAt = Utils.GetLookAt(quaternion);
                var lookUp = Utils.GetLookUp(quaternion);
                writer.WriteLine("{0},{1},{2},{3}/{4},{5},{6}/{7},{8},{9}/{10},{11},{12}",
                    quaternion.w, quaternion.x, quaternion.y, quaternion.z,
                    euler.x, euler.y, euler.z,
                    lookAt.x, lookAt.y, lookAt.z,
                    lookUp.x, lookUp.y, lookUp.z);
            }
        }
	}
}
