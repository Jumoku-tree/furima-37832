function imgPreview() {
  const postForm = document.getElementById("post-item");
  const previewList = document.getElementById("img-preview");
  if (!postForm) return null;
  const fileField = document.querySelector('input[type="file"][name="item[image]"]');
  fileField.addEventListener('change', (e) => {
    const alreadyPreview = document.querySelector('.preview');
    if (alreadyPreview) {
      alreadyPreview.remove();
    };

    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview');
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview');
    previewImage.setAttribute('src', blob);
    previewWrapper.appendChild(previewImage);
    previewList.appendChild(previewWrapper);
    const previewText = document.getElementById("preview-text");
    previewText.remove();
    });
};

window.addEventListener('load', imgPreview);