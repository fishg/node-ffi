{
  'targets': [
    {
      'target_name': 'ffi_bindings',
      'sources': [
          'src/ffi.cc'
        , 'src/callback_info.cc'
        , 'src/threaded_callback_invokation.cc'
      ],
      'include_dirs': [
        '<!(node -e "require(\'nan\')")'
      ],
      'conditions': [
        ['OS=="android"', {
          'include_dirs': [
            'deps/libffi/include',
            'deps/libffi/config/<(OS)/<(target_arch)'
          ],
          'libraries': [
            '<(module_root_dir)/deps/libffi/build/<(OS)/<(target_arch)/lib/libffi.so'
          ],
        }, {
          'dependencies': [
            'deps/libffi/libffi.gyp:ffi'
          ],
          'conditions': [
            ['OS=="win"', {
              'sources': [
                  'src/win32-dlfcn.cc'
              ],
            }],
            ['OS=="mac"', {
              'xcode_settings': {
                'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
                'OTHER_CFLAGS': [
                    '-ObjC++'
                ]
              },
              'libraries': [
                  '-lobjc'
              ],
            }]
          ]
        }]
      ]
    }
  ]
}
