class GmailTool < Formula
  include Language::Python::Virtualenv

  desc "CLI for Gmail labels and message queries"
  homepage "https://github.com/joelee/gmail-tool"
  url "https://files.pythonhosted.org/packages/90/05/8ccb95b16c7e3ce2c1ed6900337996d034d681ceb1c50d58a58cc37170cd/gmail_tool-0.3.1.tar.gz"
  sha256 "3bc59823aab8d34487020b5b718459e099657571441f8f35e40cfc1603ff89b5"
  license "MIT"

  depends_on "python@3.14"

  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/1e/d3/26bf1008eb3d2daa8ef4cacc7f3bfdc11818d111f7e2d0201bc6e3b49d45/annotated_doc-0.0.4-py3-none-any.whl"
    sha256 "571ac1dc6991c450b25a9c2d84a3705e2ae7a53467b5d111c24fa8baabbed320"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/22/30/7cd8fdcdfbc5b869528b079bfb76dcdf6056b1a2097a662e5e8c04f42965/certifi-2026.4.22-py3-none-any.whl"
    sha256 "3cb2210c8f88ba2318d29b0388d1023c8492ff72ecdde4ebdaddbb13a31b1c4a"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/db/8f/61959034484a4a7c527811f4721e75d02d653a35afb0b6054474d8185d4c/charset_normalizer-3.4.7-py3-none-any.whl"
    sha256 "3dce51d0f5e7951f8bb4900c257dad282f49190fdbebecd4ba99bcc41fef404d"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/ae/44/c1221527f6a71a01ec6fbad7fa78f1d50dfa02217385cf0fa3eec7087d59/click-8.3.3-py3-none-any.whl"
    sha256 "a2bf429bb3033c89fa4936ffb35d5cb471e3719e1f3c8a7c3fff0b8314305613"
  end

  resource "google-api-core" do
    url "https://files.pythonhosted.org/packages/03/15/e56f351cf6ef1cfea58e6ac226a7318ed1deb2218c4b3cc9bd9e4b786c5a/google_api_core-2.30.3-py3-none-any.whl"
    sha256 "a85761ba72c444dad5d611c2220633480b2b6be2521eca69cca2dbb3ffd6bfe8"
  end

  resource "google-api-python-client" do
    url "https://files.pythonhosted.org/packages/21/b9/2c71095e31fff57668fec7c07ac897df065f15521d070e63229e13689590/google_api_python_client-2.195.0-py3-none-any.whl"
    sha256 "753e62057f23049a89534bea0162b60fe391b85fb86d80bcdf884d05ec91c5bf"
  end

  resource "google-auth" do
    url "https://files.pythonhosted.org/packages/37/cf/4880c2137c14280b2f59975cdf12cc442bc0ae1f9ea473a26eaa0c146786/google_auth-2.50.0-py3-none-any.whl"
    sha256 "04382175e28b94f49694977f0a792688b59a668def1499e9d8de996dc9ce5b15"
  end

  resource "google-auth-httplib2" do
    url "https://files.pythonhosted.org/packages/97/e9/93afb14d23a949acaa3f4e7cc51a0024671174e116e35f42850764b99634/google_auth_httplib2-0.3.1-py3-none-any.whl"
    sha256 "682356a90ef4ba3d06548c37e9112eea6fc00395a11b0303a644c1a86abc275c"
  end

  resource "google-auth-oauthlib" do
    url "https://files.pythonhosted.org/packages/2a/e0/cb454a95f460903e39f101e950038ec24a072ca69d0a294a6df625cc1627/google_auth_oauthlib-1.3.1-py3-none-any.whl"
    sha256 "1a139ef23f1318756805b0e95f655c238bffd29655329a2978218248da4ee7f8"
  end

  resource "googleapis-common-protos" do
    url "https://files.pythonhosted.org/packages/b6/b0/be5d3329badb9230b765de6eea66b73abd5944bdeb5afb3562ddcd80ae84/googleapis_common_protos-1.74.0-py3-none-any.whl"
    sha256 "702216f78610bb510e3f12ac3cafd281b7ac45cc5d86e90ad87e4d301a3426b5"
  end

  resource "httplib2" do
    url "https://files.pythonhosted.org/packages/2f/90/fd509079dfcab01102c0fdd87f3a9506894bc70afcf9e9785ef6b2b3aff6/httplib2-0.31.2-py3-none-any.whl"
    sha256 "dbf0c2fa3862acf3c55c078ea9c0bc4481d7dc5117cae71be9514912cf9f8349"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/5d/13/ad7d7ca3808a898b4612b6fe93cde56b53f3034dcde235acb1f0e1df24c6/idna-3.13-py3-none-any.whl"
    sha256 "892ea0cde124a99ce773decba204c5552b69c3c67ffd5f232eb7696135bc8bb3"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/94/54/e7d793b573f298e1c9013b8c4dade17d481164aa517d1d7148619c2cedbf/markdown_it_py-4.0.0-py3-none-any.whl"
    sha256 "87327c59b172c5011896038353a81343b6754500a08cd7a4973bb48c6d578147"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/b3/38/89ba8ad64ae25be8de66a6d463314cf1eb366222074cfda9ee839c56a4b4/mdurl-0.1.2-py3-none-any.whl"
    sha256 "84008a41e51615a49fc9966191ff91509e3c40b939176e643fd50a5c2196b8f8"
  end

  resource "oauthlib" do
    url "https://files.pythonhosted.org/packages/be/9c/92789c596b8df838baa98fa71844d84283302f7604ed565dafe5a6b5041a/oauthlib-3.3.1-py3-none-any.whl"
    sha256 "88119c938d2b8fb88561af5f6ee0eec8cc8d552b7bb1f712743136eb7523b7a1"
  end

  resource "proto-plus" do
    url "https://files.pythonhosted.org/packages/84/f3/1fba73eeffafc998a25d59703b63f8be4fe8a5cb12eaff7386a0ba0f7125/proto_plus-1.27.2-py3-none-any.whl"
    sha256 "6432f75893d3b9e70b9c412f1d2f03f65b11fb164b793d14ae2ca01821d22718"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/88/95/608f665226bca68b736b79e457fded9a2a38c4f4379a4a7614303d9db3bc/protobuf-7.34.1-py3-none-any.whl"
    sha256 "bb3812cd53aefea2b028ef42bd780f5b96407247f20c6ef7c679807e9d188f11"
  end

  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/5d/a0/7d793dce3fa811fe047d6ae2431c672364b462850c6235ae306c0efd025f/pyasn1-0.6.3-py3-none-any.whl"
    sha256 "a80184d120f0864a52a073acc6fc642847d0be408e7c7252f31390c0f4eadcde"
  end

  resource "pyasn1-modules" do
    url "https://files.pythonhosted.org/packages/47/8d/d529b5d697919ba8c11ad626e835d4039be708a35b0d22de83a269a6682c/pyasn1_modules-0.4.2-py3-none-any.whl"
    sha256 "29253a9207ce32b64c3ac6600edc75368f98473906e8fd1043bd6b5b1de2c14a"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0c/c3/44f3fbbfa403ea2a7c779186dc20772604442dde72947e7d01069cbe98e3/pycparser-3.0-py3-none-any.whl"
    sha256 "b727414169a36b7d524c1c3e31839a521725078d7b2ff038656844266160a992"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/f4/7e/a72dd26f3b0f4f2bf1dd8923c85f7ceb43172af56d63c7383eb62b332364/pygments-2.20.0-py3-none-any.whl"
    sha256 "81a9e26dd42fd28a23a2d169d86d7ac03b46e2f8b59ed4698fb4785f946d0176"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/10/bd/c038d7cc38edc1aa5bf91ab8068b63d4308c66c4c8bb3cbba7dfbc049f9c/pyparsing-3.3.2-py3-none-any.whl"
    sha256 "850ba148bd908d7e2411587e247a1e4f0327839c40e2e5e6d05a007ecc69911d"
  end

  resource "python-dotenv" do
    url "https://files.pythonhosted.org/packages/0b/d7/1959b9648791274998a9c3526f6d0ec8fd2233e4d4acce81bbae76b44b2a/python_dotenv-1.2.2-py3-none-any.whl"
    sha256 "1d8214789a24de455a8b8bd8ae6fe3c6b69a5e3d64aa8a8e5d68e694bbcb285a"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/d7/8e/7540e8a2036f79a125c1d2ebadf69ed7901608859186c856fa0388ef4197/requests-2.33.1-py3-none-any.whl"
    sha256 "4e6d1ef462f3626a1f0a0a9c42dd93c63bad33f9f1c1937509b8c5c8718ab56a"
  end

  resource "requests-oauthlib" do
    url "https://files.pythonhosted.org/packages/3b/5d/63d4ae3b9daea098d5d6f5da83984853c1bbacd5dc826764b249fe119d24/requests_oauthlib-2.0.0-py2.py3-none-any.whl"
    sha256 "7dd8a5c40426b779b0868c404bdef9768deccf22749cde15852df527e6269b36"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/82/3b/64d4899d73f91ba49a8c18a8ff3f0ea8f1c1d75481760df8c68ef5235bf5/rich-15.0.0-py3-none-any.whl"
    sha256 "33bd4ef74232fb73fe9279a257718407f169c09b78a87ad3d296f548e27de0bb"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/e0/f9/0595336914c5619e5f28a1fb793285925a8cd4b432c9da0a987836c7f822/shellingham-1.5.4-py2.py3-none-any.whl"
    sha256 "7ecfff8f2fd72616f7481040475a65b2bf8af90a56c89140852d1120324e8686"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/3f/f9/2b3ff4e56e5fa7debfaf9eb135d0da96f3e9a1d5b27222223c7296336e5f/typer-0.25.1-py3-none-any.whl"
    sha256 "75caa44ed46a03fb2dab8808753ffacdbfea88495e74c85a28c5eefcf5f39c89"
  end

  resource "uritemplate" do
    url "https://files.pythonhosted.org/packages/a9/99/3ae339466c9183ea5b8ae87b34c0b897eda475d2aec2307cae60e5cd4f29/uritemplate-4.2.0-py3-none-any.whl"
    sha256 "962201ba1c4edcab02e60f9a0d3821e82dfc5d2d6662a21abd533879bdb8a686"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/39/08/aaaad47bc4e9dc8c725e68f9d04865dbcb2052843ff09c97b08904852d84/urllib3-2.6.3-py3-none-any.whl"
    sha256 "bf272323e553dfb2e87d9bfd225ca7b0f467b919d7bbd355436d3fd37cb0acd4"
  end

  on_macos do
    resource "cryptography" do
      url "https://files.pythonhosted.org/packages/a4/98/40dfe932134bdcae4f6ab5927c87488754bf9eb79297d7e0070b78dd58e9/cryptography-47.0.0-cp311-abi3-macosx_10_9_universal2.whl"
      sha256 "160ad728f128972d362e714054f6ba0067cab7fb350c5202a9ae8ae4ce3ef1a0"
    end

    on_arm do
      resource "cffi" do
        url "https://files.pythonhosted.org/packages/59/dd/27e9fa567a23931c838c6b02d0764611c62290062a6d4e8ff7863daf9730/cffi-2.0.0-cp314-cp314-macosx_11_0_arm64.whl"
        sha256 "c654de545946e0db659b3400168c9ad31b5d29593291482c43e3564effbcee13"
      end

    end

    on_intel do
      resource "cffi" do
        url "https://files.pythonhosted.org/packages/92/c4/3ce07396253a83250ee98564f8d7e9789fab8e58858f35d07a9a2c78de9f/cffi-2.0.0-cp314-cp314-macosx_10_13_x86_64.whl"
        sha256 "fc33c5141b55ed366cfaad382df24fe7dcbc686de5be719b207bb248e3053dc5"
      end

    end

  end

  on_linux do
    on_arm do
      resource "cffi" do
        url "https://files.pythonhosted.org/packages/d6/43/0e822876f87ea8a4ef95442c3d766a06a51fc5298823f884ef87aaad168c/cffi-2.0.0-cp314-cp314-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"
        sha256 "24b6f81f1983e6df8db3adc38562c83f7d4a0c36162885ec7f7b77c7dcbec97b"
      end

      resource "cryptography" do
        url "https://files.pythonhosted.org/packages/34/c6/2733531243fba725f58611b918056b277692f1033373dcc8bd01af1c05d4/cryptography-47.0.0-cp311-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"
        sha256 "b9a8943e359b7615db1a3ba587994618e094ff3d6fa5a390c73d079ce18b3973"
      end

    end

    on_intel do
      resource "cffi" do
        url "https://files.pythonhosted.org/packages/47/d9/d83e293854571c877a92da46fdec39158f8d7e68da75bf73581225d28e90/cffi-2.0.0-cp314-cp314-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
        sha256 "afb8db5439b81cf9c9d0c80404b60c3cc9c3add93e114dcae767f1477cb53775"
      end

      resource "cryptography" do
        url "https://files.pythonhosted.org/packages/00/e3/b27be1a670a9b87f855d211cf0e1174a5d721216b7616bd52d8581d912ed/cryptography-47.0.0-cp311-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
        sha256 "f5c15764f261394b22aef6b00252f5195f46f2ca300bec57149474e2538b31f8"
      end

    end

  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gmail-tool --version")
    assert_match "backup", shell_output("#{bin}/gmail-tool search --list-actions")
  end
end
