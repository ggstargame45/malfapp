class NationImage {
  static Set<String> hasImage = {
    '608',
    '702',
    '288',
    '860',
    '724',
    '643',
    '792',
    '344',
    '528',
    '380',
    '586',
    '840',
    '56',
    '056',
    '484',
    '144',
    '756',
    '392',
    '276',
    '36',
    '496',
    '32',
    '116',
    '704',
    '410',
    '804',
    '032',
    '826',
    '76',
    '524',
    '554',
    '458',
    '360',
    '124',
    '156',
    '158',
    '752',
    '356',
    '764',
    '616',
    '710',
    '364',
    '250',
    '170',
    '076',
    '036',
    '372'
  };
  static String getImage(String nationId) {
    if (hasImage.contains(nationId)) {
      if (nationId.length == 2) nationId = '0$nationId';
      return 'assets/images/country_images/${nationId}_back.jpeg';
    }
    return 'assets/images/country_images/non_back.jpeg';
  }
}
