from PIL import Image

def combine_images():
    img1_path = "c:/Users/dathao/Downloads/AI/git-final-practice/erd-order-management/erd_chen_model.png"
    img2_path = "c:/Users/dathao/Downloads/AI/git-final-practice/erd-order-management/erd_relational_3nf.png"
    out_path = "c:/Users/dathao/Downloads/AI/git-final-practice/erd-order-management/erd_diagram.png"

    img1 = Image.open(img1_path)
    img2 = Image.open(img2_path)

    # Resize to have same width
    target_width = max(img1.width, img2.width)
    img1_resized = img1.resize((target_width, int(img1.height * target_width / img1.width)), Image.Resampling.LANCZOS)
    img2_resized = img2.resize((target_width, int(img2.height * target_width / img2.width)), Image.Resampling.LANCZOS)

    total_height = img1_resized.height + img2_resized.height + 40
    combined = Image.new('RGB', (target_width, total_height), color=(255, 255, 255))

    combined.paste(img1_resized, (0, 0))
    combined.paste(img2_resized, (0, img1_resized.height + 40))

    combined.save(out_path, quality=95)
    print(f"Combined ERD image saved at {out_path}")

    # Also save to standalone folder
    standalone_path = "c:/Users/dathao/Downloads/AI/erd-order-management/erd_diagram.png"
    combined.save(standalone_path, quality=95)
    img1.save("c:/Users/dathao/Downloads/AI/erd-order-management/erd_chen_model.png")
    img2.save("c:/Users/dathao/Downloads/AI/erd-order-management/erd_relational_3nf.png")
    print(f"Standalone images copied successfully.")

if __name__ == "__main__":
    combine_images()
