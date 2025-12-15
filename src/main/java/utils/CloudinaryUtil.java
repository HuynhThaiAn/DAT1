package utils;

import com.cloudinary.Cloudinary;

public class CloudinaryUtil {
    private static final String CLOUDINARY_URL =
            "cloudinary://749464297861192:OFP-if1xPFVbnWR6v2gXBShL5So@dsjawxwjh"; // thay API_KEY, API_SECRET

    private static Cloudinary cloudinary;
    

    public static synchronized Cloudinary getInstance() {
        if (cloudinary == null) {
            cloudinary = new Cloudinary(CLOUDINARY_URL);
        }
        return cloudinary;
    }
}
